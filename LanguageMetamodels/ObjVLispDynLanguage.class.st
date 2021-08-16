Class {
	#name : #ObjVLispDynLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
ObjVLispDynLanguage class >> classModel [
	" Return the subclass of ClassModel that defines the metamodel for classes of the language "
	^ ObjVLispMinClass
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> classModelFor: aString [
	^ (aString endsWith: self dynClassSuffix)
		ifTrue: [ self dynClassModel ]
		ifFalse: [ self classModel ]
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> customModels [
	^ {DynamicVariableModel}
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> dynClassModel [
	^ ObjVLispDynClass
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> dynClassSuffix [
	^ 'Dyn'
]

{ #category : #hooks }
ObjVLispDynLanguage >> createClassTest1Dyn [
	| test1 |
	test1 := self ensureClassNamed: #Test1Dyn.
	self assert: test1 class = ObjVLispDynClass.
	test1 addLocalMethodFromSource: 'test
	|  out holahola |
	holahola := ''hola''.
	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.
	
	out := Test2Dyn new.
	System log: ''TEMP AT 1(out):'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2(holahola):'', (thisContext tempAt:2) asString.

	"out readHolaFromOutside.
		System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
		System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString."
	
	out writeHolaFromOutside.
	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.
	System log: holahola asString.
	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.

	System log: holahola asString.
	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.
	System log: ''self readHolaHola, should be hola''.
	self readHolahola.

	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.
	System log: holahola asString.

	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.

	System log: ''self writeHolahola, should be chao''.
	self writeHolahola.
	
	System log: ''TEMP AT 1:'', (thisContext tempAt:1) asString.
	System log: ''TEMP AT 2:'', (thisContext tempAt:2) asString.
	System log: ''holahola asString, should be chao''.	
	System log: holahola asString.' selector: #test.
	
	test1 addLocalMethodFromSource: 'readHolahola
	^ holahola' selector: #readHolahola.
	test1 addLocalMethodFromSource: 'writeHolahola
	^ holahola := #chao' selector: #writeHolahola.
	
]

{ #category : #hooks }
ObjVLispDynLanguage >> createClassTest2Dyn [
	| test2 |
	test2 := self ensureClassNamed: #Test2Dyn.
	self assert: test2 class = ObjVLispDynClass. 
	test2 addLocalMethodFromSource: 'readHolaFromOutside
	System log: ''Leyendo desde DynamicTest2: '', holahola asString' 
	selector: #readHolaFromOutside.
	test2 addLocalMethodFromSource: 'writeHolaFromOutside
	holahola := 12' 
	selector: #writeHolaFromOutside
]

{ #category : #hooks }
ObjVLispDynLanguage >> transform [ 
	super transform.
	self transformKernelClasses.
	self transformDynamicVariableClass.
	self transformTestClasses.
]

{ #category : #hooks }
ObjVLispDynLanguage >> transformDynamicVariableClass [
	| classDynVar |
	classDynVar := self classWithRole: #DynamicVariable.
	self assert: (classDynVar slotNamed: #index) isNotNil.
	self assert: (classDynVar slotNamed: #name) isNotNil.
	
	classDynVar addLocalMethodFromSource: 'read
	| context var |
	context := thisContext sender.
	System log: ''DynVar>>read''.
	[ context isNil ] whileFalse: [ 
		var := context method dynamicVariableNamed: name.
		System log: context asString, '' (var is'', var asString, '')''.
		(var isNil not) ifTrue: [ 
			^ context tempAt: var index ].
		context :=  context sender
	].
	^ nil' selector: #read.
	classDynVar addLocalMethodFromSource: 'write: anObject
	| context var |
	context := thisContext sender.
	System log: ''DynVar>>write:'', anObject asString.
	[ context isNil ] whileFalse: [ 
		var := context method dynamicVariableNamed: name.
		System log: context asString, '' (var is'', var asString, '')''.
		(var isNil not) ifTrue: [ 
			^ context tempAt: var index put: anObject ].
		context :=  context sender
	].
	^ nil' selector: #write:.
	classDynVar addLocalMethodFromSource: 'name 
	^ name' selector: #name.
	classDynVar addLocalMethodFromSource: 'index 
	^ index' selector: #index.
	
]

{ #category : #hooks }
ObjVLispDynLanguage >> transformKernelClasses [
	| assocClass objectClass methodClass |
	objectClass := self classProtoObject.
	objectClass addLocalMethodFromSource: 'isVariableBinding 
	^ false' selector: #isVariableBinding.
	
	assocClass := self classWithRole: 'Association'.
	assocClass addLocalMethodFromSource: 'isVariableBinding 
	^ true' selector: #isVariableBinding.
	
	methodClass := self classWithRole: #CompiledMethod.
	methodClass addSlot: 'literalNames'.
	methodClass addLocalMethodFromSource: 'allLiterals
	"Answer an Array of the literals referenced by the receiver.	
	 including superclass + selector/properties"
	| literals numberLiterals |
	literals := Array new: (numberLiterals := self numLiterals).
	1 to: numberLiterals do: [:index |
		literals at: index put: (self objectAt: index + 1)].
	^literals' selector: #allLiterals.
	methodClass addLocalMethodFromSource: 'indexOfLiteralBinding: aSymbol
	self allLiterals withIndexDo: [:each :index |
		(((each isVariableBinding 
 			and: [ each key = aSymbol asSymbol ])
 			and: [ each value index isNil not ])
			and: [ each value index > 0]) 
		ifTrue: [^ index].		
	].
	^ nil' selector: #indexOfLiteralBinding:.
	methodClass addLocalMethodFromSource: 'dynamicVariableNamed:aSymbol	
	self allLiterals withIndexDo: [:each :index |
		((((each isVariableBinding 
		 	and: [ each key = #dynvar ])
		 	and: [ each value index isNil not ])
			and: [ each value index > 0])
			and: [ each value name asSymbol = aSymbol asSymbol]) 
		ifTrue: [^ each value].		
	].
	^ nil' selector: #dynamicVariableNamed:.
	
]

{ #category : #hooks }
ObjVLispDynLanguage >> transformTestClasses [
	self createClassTest1Dyn.
	self createClassTest2Dyn
]
