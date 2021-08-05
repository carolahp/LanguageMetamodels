Class {
	#name : #CandleFromObjVLispLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #'hooks-api' }
CandleFromObjVLispLanguage class >> classModel [
	^ CandleFromObjVLispClass
]

{ #category : #metamodel }
CandleFromObjVLispLanguage class >> customModels [
	^ { CandleFromObjVLispMetaclass }
]

{ #category : #metamodel }
CandleFromObjVLispLanguage class >> globalModel [
	^ GlobalModel
]

{ #category : #'hooks-api' }
CandleFromObjVLispLanguage class >> metaclassModel [
	^ CandleFromObjVLispMetaclass
]

{ #category : #'hooks-api' }
CandleFromObjVLispLanguage class >> metaclassSuffix [
	^ ' class'
]

{ #category : #roles }
CandleFromObjVLispLanguage >> basicNewMetaclassNamed: aName [
	^ self class metaclassModel basicNew 
		name: aName asSymbol;
		parent: self;
		yourself
]

{ #category : #'model updating' }
CandleFromObjVLispLanguage >> classClass [ 
	^ self classNamed: #Class
]

{ #category : #'special classes' }
CandleFromObjVLispLanguage >> classMetaclass [
	^ self classWithRole: #Metaclass
]

{ #category : #'metaclass name' }
CandleFromObjVLispLanguage >> classNameFrom: aString [ 
	^ aString copyReplaceAll: 'Meta' with: ''
]

{ #category : #'metaclass name' }
CandleFromObjVLispLanguage >> classOrMetaclassNameFrom: aString [ 
	^ aString copyReplaceAll: 'Meta' with: self class metaclassSuffix 
]

{ #category : #hooks }
CandleFromObjVLispLanguage >> createInitialObjects [
	"| classes |
	classes := self allClasses
		select: [ :class | class isCandleClass and: [ class remote isNotNil ] ].
	classes do: [ :class | class initializeClassVars ]."
	"self evaluateCode: 'Float initialize'."
]

{ #category : #hooks }
CandleFromObjVLispLanguage >> createRemoteSystemDictionary [
	^ nil
]

{ #category : #roles }
CandleFromObjVLispLanguage >> customClassRoles [ 
	^ { 
	#ProtoObject -> #Object.
	#Class -> #Class.
	#Metaclass -> #Metaclass }
]

{ #category : #roles }
CandleFromObjVLispLanguage >> ensureClassNamed: aName [
	| name |
	
	name := self classOrMetaclassNameFrom: aName.
	
	^ self
		classNamed: name
		ifAbsent: [ | newBeh |
			newBeh := (self isValidMetaclassName: name)
				ifTrue: [ self class metaclassModel named: name parent: self ]
				ifFalse: [ self class classModel named: name parent: self ].
			self addBehavior: newBeh.
			newBeh ]
]

{ #category : #'model updating' }
CandleFromObjVLispLanguage >> ensureMetaclassNamed: aName [ 
	self assert: (self isValidMetaclassName: aName).
	^ self
		classNamed: aName
		ifAbsent: [ | newBeh |
			newBeh := self basicNewMetaclassNamed: aName.
			self addBehavior: newBeh.
			newBeh initialize.
			newBeh ]
]

{ #category : #hooks }
CandleFromObjVLispLanguage >> firstMetaclasses [
	| metaclass |
	metaclass := self classMetaclass.
	^ { metaclass . metaclass metaclass }
]

{ #category : #hooks }
CandleFromObjVLispLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #roles }
CandleFromObjVLispLanguage >> isValidMetaclassName: aString [
	^ (aString endsWith: self class metaclassSuffix)
		and: [ aString size > self class metaclassSuffix size
				and: [ (aString occurrencesOf: Character space) = 1 ] ]
]

{ #category : #roles }
CandleFromObjVLispLanguage >> loadGlobalVariables [
	^ nil
]

{ #category : #'model updating' }
CandleFromObjVLispLanguage >> loadKernel [
	| object class metaclass |
	
	object := self basicNewClassWithRole: #ProtoObject.
	self addBehavior: object.
	
	class := self basicNewClassWithRole: #Class.
	self addBehavior: class.
	
	
	metaclass := self basicNewClassWithRole: #Metaclass.
	self addBehavior: metaclass.
	"objectClass := self class metaclassModel basicNew
		name: #'Object class';
		parent: self.
	objectClass superclass: class."
	
	object superclass: nil.
	class superclass: object.
	metaclass superclass: object.
	
	
	metaclass initialize.
	object initialize.
	class initialize.
	
]

{ #category : #roles }
CandleFromObjVLispLanguage >> newMetaclassNamed: aName [
	^ self class metaclassModel named: aName asSymbol parent: self
]

{ #category : #roles }
CandleFromObjVLispLanguage >> test [ 
	| class object metaclass |
	super test.
	
	class := self classClass.
	object:= self classProtoObject.
	metaclass := self classMetaclass.
	
	self assert: metaclass metaclass ~= metaclass.
	self assert: metaclass metaclass metaclass = metaclass.
	self assert: object superclass isNil.
	self assert: object metaclass superclass = class.
]

{ #category : #roles }
CandleFromObjVLispLanguage >> transform [
	^ self 
]
