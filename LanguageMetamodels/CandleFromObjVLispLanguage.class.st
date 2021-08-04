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

{ #category : #'metaclass name' }
CandleFromObjVLispLanguage >> classOrMetaclassNameFrom: aString [ 
	^ aString copyReplaceAll: 'Meta' with: self class metaclassSuffix 
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
	| model metamodel modelVars metamodelVars modelVarsLast metamodelVarsLast |
	super test.
	
	model := self classClass.
	metamodel := self class classModel.
	
	modelVars := model allInstVarNames.
	metamodelVars := self class classModel allClassModelInstVarNames.
	
	modelVarsLast := (modelVars
		copyFrom: 4
		to: modelVars size) asIdentitySet.
		
	metamodelVarsLast := (metamodelVars
		copyFrom: 4
		to: metamodelVars size) asIdentitySet.
	
	self
		assert: (modelVars beginsWith: (metamodelVars copyFrom: 1 to: 3))
		description:
			'The first 3 instance variables of "' , model name
				, '" must be ' , (metamodelVars copyFrom: 1 to: 3) asString.
	
	self
		assert: (metamodelVarsLast asSet difference: modelVarsLast asSet) isEmpty
		description:
			'The class ' , metamodel asString
				, ' must define the same instance variables as '
				, model name asString.
]

{ #category : #roles }
CandleFromObjVLispLanguage >> transform [
	| classes object metaclass areMeta areNotMeta |
	
	metaclass := self classMetaclass.
	metaclass name: #Metaclass.
	
	object := self classWithRole: #ProtoObject.
	
	classes := self allClasses reject: [ :aClass | aClass = metaclass or: [aClass = object] ].
	
	object metaclass: (self ensureMetaclassNamed: object name, self class metaclassSuffix).
	object metaclass 
		layout: (EP2FixedLayout on: object metaclass);
		superclass: self classClass;
		soleInstance: object.
	
	metaclass 
		removeSlot: 'metaclass';
		removeSlot: 'name';
		addSlot: 'soleInstance'.
	
	metaclass metaclass: (self ensureMetaclassNamed: metaclass name, self class metaclassSuffix).
	metaclass metaclass 
		layout: (EP2FixedLayout on: metaclass metaclass);
		superclass: object metaclass;
		soleInstance: metaclass.
	
	
	areMeta := (classes select: #isMetaclass) asSet.
	areNotMeta := (classes difference: areMeta) asSet.
	
	areNotMeta do: [ :aClass | | newMeta |
		newMeta := self ensureMetaclassNamed: aClass name, self class metaclassSuffix.
		newMeta initializeWithSoleInstance: aClass.
		newMeta methodDict: aClass metaclass methodDict clone.
		aClass metaclass: newMeta.].
	
	
]
