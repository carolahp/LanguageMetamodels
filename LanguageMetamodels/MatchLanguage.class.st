"
Match is ObjVLisp with implicit metaclasses. Its source code is the same as ObjVLisp
"
Class {
	#name : #MatchLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-Match'
}

{ #category : #'hooks-api' }
MatchLanguage class >> classModel [
	^ MatchClass
]

{ #category : #'hooks-api' }
MatchLanguage class >> classModelFor: aString [
	^ (aString endsWith: self metaclassSuffix)
		ifTrue: [ self metaclassModel ]
		ifFalse: [ self classModel ]
]

{ #category : #metamodel }
MatchLanguage class >> customModels [
	^ { self metaclassModel }
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

{ #category : #'tonel repository' }
MatchLanguage >> classNameFromMonticello: aString [ 
	
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
	^ { #ProtoObject -> #Object }
]

{ #category : #'model updating' }
MatchLanguage >> ensureMetaclassNamed: aName [ 
	self assert: (self isValidMetaclassName: aName).
	^ self
		classNamed: aName
		ifAbsent: [ | newBeh |
			newBeh := self basicNewMetaclassNamed: aName.
			self addClass: newBeh.
			newBeh initialize.
			newBeh ]
]

{ #category : #hooks }
MatchLanguage >> firstMetaclasses [
	| metaclass |
	metaclass := self classMetaclass.
	^ { metaclass . metaclass metaclass }
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
	| object class metaclass objectClass |
	object := self basicNewClassWithRole: #ProtoObject.
	self addClass: object.
	class := self basicNewClassWithRole: #Class.
	self addClass: class.
	metaclass := self basicNewClassWithRole: #Metaclass.
	self addClass: metaclass.
	object superclass: nil.
	class superclass: object.
	metaclass superclass: object.
	objectClass := (self basicNewClassNamed: object name, self class metaclassSuffix)
		parent: self;
		yourself.
	objectClass superclass: class.
	self addClass: objectClass.
	metaclass initialize.
	object initialize.
	class initialize.
	objectClass initialize
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
	self classClass
		addLocalMethodFromSource:
			'name 
	^ name'
		selector: #name.
	self classClass
		addLocalMethodFromSource:
			'instVarsNames 
	^ instVarsNames'
		selector: #instVarsNames
]
