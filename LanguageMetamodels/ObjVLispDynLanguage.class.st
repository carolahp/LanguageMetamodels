"
ObjVLisp with dynamic temporaries. 
Allowing methods to define temporaries whose scope is dynamic, i.e. they access and modify temporaries that are defined out of their scope. 
Example:
MyClass >> readX 
	^ x
MyClass >> test 
	| x |
	x := 3.
	System log: self readX ""prints 3""
Only methods returning DynamicVariableModel from the hook #tempVariableModel use dynamic temporaries.
"
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
ObjVLispDynLanguage class >> customFirstClassModels [
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

{ #category : #metamodel }
ObjVLispDynLanguage class >> undeclaredVariableModel [
	^ ObjVLispDynUndeclaredVariable
]

{ #category : #hooks }
ObjVLispDynLanguage >> createClassTest1Dyn [
	| test1 |
	test1 := self ensureClassNamed: #Test1Dyn.
	self assert: test1 class = ObjVLispDynClass.
	test1 addLocalMethodFromSource: 'test
	|  out holahola |
	out := Test2Dyn new.
	holahola := ''hola''.
	System log: holahola asString. "prints hola"
	System log: out readHolaFromOutside asString. "prints hola"
	out writeHolaFromOutside.
	System log: holahola asString. "prints 12"
	System log: self readHolahola asString. "prints 12"
	self writeHolahola.
	System log: holahola asString "prints chao".
	System log: out readHolaFromOutside asString. "prints chao"' selector: #test.
	
	test1 addLocalMethodFromSource: 'readHolahola
	^ holahola' selector: #readHolahola.
	test1 addLocalMethodFromSource: 'writeHolahola
	holahola := #chao' selector: #writeHolahola.
	
]

{ #category : #hooks }
ObjVLispDynLanguage >> createClassTest2Dyn [
	| test2 |
	test2 := self ensureClassNamed: #Test2Dyn.
	self assert: test2 class = ObjVLispDynClass. 
	test2 addLocalMethodFromSource: 'readHolaFromOutside
	^ holahola' 
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
	[ context isNil ] whileFalse: [ 
		var := context method dynamicVariableNamed: name.
		(var isNil not) ifTrue: [ 
			^ context tempAt: var index ].
		context :=  context sender
	].
	^ nil' selector: #read.
	classDynVar addLocalMethodFromSource: 'write: anObject
	| context var |
	context := thisContext sender.
	[ context isNil ] whileFalse: [ 
		var := context method dynamicVariableNamed: name.
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

{ #category : #hooks }
ObjVLispDynLanguage >> undeclaredVariableModel [
	^ ObjVLispDynUndeclaredVariable
]
