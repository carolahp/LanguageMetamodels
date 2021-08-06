Class {
	#name : #MatchLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-Match'
}

{ #category : #'hooks-api' }
MatchLanguage class >> classModel [
	^ MatchClass
]

{ #category : #metamodel }
MatchLanguage class >> customModels [
	^ { MatchMetaclass }
]

{ #category : #metamodel }
MatchLanguage class >> globalModel [
	^ GlobalModel
]

{ #category : #'hooks-api' }
MatchLanguage class >> metaclassModel [
	^ MatchMetaclass
]

{ #category : #'hooks-api' }
MatchLanguage class >> metaclassSuffix [
	^ ' class'
]

{ #category : #roles }
MatchLanguage >> basicNewMetaclassNamed: aName [
	^ self class metaclassModel basicNew 
		name: aName asSymbol;
		parent: self;
		yourself
]

{ #category : #'model updating' }
MatchLanguage >> classClass [ 
	^ self classNamed: #Class
]

{ #category : #'special classes' }
MatchLanguage >> classMetaclass [
	^ self classWithRole: #Metaclass
]

{ #category : #'metaclass name' }
MatchLanguage >> classNameFrom: aString [ 
	^ aString copyReplaceAll: 'Meta' with: ''
]

{ #category : #'metaclass name' }
MatchLanguage >> classOrMetaclassNameFrom: aString [ 
	^ aString copyReplaceAll: 'Meta' with: self class metaclassSuffix 
]

{ #category : #hooks }
MatchLanguage >> createInitialObjects [
	"| classes |
	classes := self allClasses
		select: [ :class | class isCandleClass and: [ class remote isNotNil ] ].
	classes do: [ :class | class initializeClassVars ]."
	"self evaluateCode: 'Float initialize'."
]

{ #category : #hooks }
MatchLanguage >> createRemoteSystemDictionary [
	^ nil
]

{ #category : #roles }
MatchLanguage >> customClassRoles [ 
	^ { 
	#ProtoObject -> #Object.
	#Class -> #Class.
	#Metaclass -> #Metaclass }
]

{ #category : #roles }
MatchLanguage >> ensureClassNamed: aName [
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
MatchLanguage >> ensureMetaclassNamed: aName [ 
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
MatchLanguage >> firstMetaclasses [
	| metaclass |
	metaclass := self classMetaclass.
	^ { metaclass . metaclass metaclass }
]

{ #category : #hooks }
MatchLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #roles }
MatchLanguage >> isValidMetaclassName: aString [
	^ (aString endsWith: self class metaclassSuffix)
		and: [ aString size > self class metaclassSuffix size
				and: [ (aString occurrencesOf: Character space) = 1 ] ]
]

{ #category : #roles }
MatchLanguage >> loadGlobalVariables [
	^ nil
]

{ #category : #'model updating' }
MatchLanguage >> loadKernel [
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
MatchLanguage >> newMetaclassNamed: aName [
	^ self class metaclassModel named: aName asSymbol parent: self
]

{ #category : #roles }
MatchLanguage >> test [ 
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
MatchLanguage >> transform [
	^ self 
]
