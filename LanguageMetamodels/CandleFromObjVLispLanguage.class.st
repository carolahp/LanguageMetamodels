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
				ifTrue: [ self halt.self class metaclassModel named: aName parent: self ]
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

{ #category : #roles }
CandleFromObjVLispLanguage >> test [ 
	| model metamodel modelVars metamodelVars modelVarsLast metamodelVarsLast |
	super test.
		
	model := self classNamed: 'Class'.
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
	| metaclass haveMetaclassMeta dontHaveMetaclassMeta areMeta areNotMeta |
	metaclass := self classWithRole: #Metaclass.
	metaclass
		addSlot: 'instVarsNames';
		addSlot: 'classVars'.
	areMeta := (self allClasses
		select: [ :class | class name endsWith: 'Meta' ]) asSet.
	areNotMeta := (self allClasses
		select: [ :class | (class name endsWith: 'Meta') not ]) asSet.

	"tienen metaclass Meta"
	haveMetaclassMeta := (self allClasses
		select: [ :class | class metaclass name endsWith: 'Meta' ]) asSet.
	"no tienen metaclass Meta"
	dontHaveMetaclassMeta := (self allClasses
		select: [ :class | (class metaclass name endsWith: 'Meta') not ])
		asSet.
	self assert: (areMeta asSet intersection: haveMetaclassMeta) isEmpty.
	areMeta
		do: [ :class | 
			class becomeMetaclass ].
	self halt.
	"are not Meta and their metaclass is Class"
	(areNotMeta asSet intersection: dontHaveMetaclassMeta)
		do: [ :class | class metaclass: (self ensureMetaclassFor: class) ].
]
