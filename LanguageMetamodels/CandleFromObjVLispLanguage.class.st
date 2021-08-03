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

{ #category : #'hooks-api' }
CandleFromObjVLispLanguage class >> metaclassSuffixInObjVLisp [
	^ 'Meta'
]

{ #category : #'model updating' }
CandleFromObjVLispLanguage >> classClass [ 
	^ self classNamed: #Class
]

{ #category : #roles }
CandleFromObjVLispLanguage >> customClassRoles [ 
	^ nil
]

{ #category : #roles }
CandleFromObjVLispLanguage >> ensureClassNamed: aName [
	^ self
		classNamed: aName
		ifAbsent: [ | newBeh |
			newBeh := (self isValidMetaclassName: aName)
				ifTrue: [ self class metaclassModel named: aName parent: self ]
				ifFalse: [ self class classModel named: aName parent: self ].
			self addBehavior: newBeh.
			newBeh ]
]

{ #category : #'model updating' }
CandleFromObjVLispLanguage >> ensureMetaclassNamed: aName [ 
	self assert: (self isValidMetaclassName: aName).
	^ self
		classNamed: aName
		ifAbsent: [ | newBeh |
			newBeh := self class metaclassModel named: aName parent: self.
			self addBehavior: newBeh.
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
	| object class metaclass behavior |
	" load the first classes necessary to create the rest "
	" OVERRIDE if your language has implicit metaclasses "
	object := self class classModel basicNew
		name: #Object;
		parent: self.
	object role: #ProtoObject.
	object template: EP2RemoteEmpty.
	object layout: (EP2RemoteEmpty layoutClass on: object).
	(self packageNamed: self defaultPackageName) addDefinedBehavior: object.
	object superclass: nil.
	self addBehavior: object.
	self halt.
	behavior := self class classModel basicNew
		name: #Behavior;
		parent: self.
	behavior layout: (EP2FixedLayout on: behavior).
	(self packageNamed: self defaultPackageName) addDefinedBehavior: behavior.
	EP2RemoteClass modelInstVarNames 
		doWithIndex: [ :ivname :index| behavior addSlot: ivname index: index ].
	behavior superclass: object.
	self addBehavior: behavior.
	
	class := self class classModel basicNew
		name: #Class;
		parent: self.
	class role: #Class.
	class superclass: behavior.
	class layout: (EP2FixedLayout on: class).
	(self packageNamed: self defaultPackageName) addDefinedBehavior: class.
	class addSlot: #name;
		addSlot: #instVarsNames;
		addSlot: #classVars.
	self addBehavior: class.
	
	metaclass := self class classModel basicNew
		name: #Metaclass;
		parent: self.
	metaclass role: #Metaclass.
	metaclass superclass: behavior.
	metaclass layout: (EP2FixedLayout on: metaclass).
	(self packageNamed: self defaultPackageName) addDefinedBehavior: metaclass.
	metaclass addSlot: #soleInstance.
	self addBehavior: metaclass.
	
	metaclass metaclass metaclass: metaclass.
	behavior initialize.
	class initialize.
	object initialize.
	object metaclass metaclass: metaclass.
	object metaclass superclass: class.
	self halt.
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
	
	metaclass := self classWithRole: #Metaclass.
	metaclass name: #Metaclass.
	
	object := self classWithRole: #ProtoObject.
	
	classes := self allClasses reject: [ :aClass | aClass = metaclass or: [aClass = object] ].
	
	object metaclass: (self ensureMetaclassNamed: object name, self class metaclassSuffix).
	object metaclass 
		layout: (EP2FixedLayout on: object metaclass);
		superclass: (self classNamed: #Class);
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
