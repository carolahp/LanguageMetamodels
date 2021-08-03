Class {
	#name : #ObjVLispDynLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
ObjVLispDynLanguage class >> classModel [
	" Return the subclass of ClassModel that defines the metamodel for classes of the language "
	"^ ObjVLispDynClass "
	^ ObjVLispMinClass
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> tempVariableModel [
	self deprecated: 'Use MethodModel >> tempVariableModel'.
	^ DynamicVariableModel
	"^ TempVariableModel"
]

{ #category : #hooks }
ObjVLispDynLanguage >> transform [ 
	| newClass1 newClass2 oldClass1 oldClass2 |
	
	newClass1 := ObjVLispDynClass named: #DynTest parent: self.
	newClass2 := ObjVLispDynClass named: #DynTest2 parent: self.
	newClass1 layout: (EP2FixedLayout on: newClass1).
	newClass2 layout: (EP2FixedLayout on: newClass2).
	newClass1 superclass: (self classNamed: 'Object').
	newClass2 superclass: (self classNamed: 'Object').
	newClass1 metaclass: (self classNamed: 'Class').
	newClass2 metaclass: (self classNamed: 'Class').
	newClass1 package: (self classNamed: 'DynamicTest') package.
	newClass2 package: (self classNamed: 'DynamicTest') package.
		

	newClass1 addLocalMethodFromSource: 'test 
	|  out holahola |
	holahola := ''hola''.
	out := DynamicTest2 new.
	out writeHolaFromOutside.
	System log: holahola asString.
	System log: holahola asString.
	self readHolahola.
	System log: holahola asString.
	self writeHolahola.
	System log: holahola asString.'
	 selector: #test.
	
	newClass1 addLocalMethodFromSource: 'readHolahola
	^ holahola'
	 selector: #readHolahola.
	
	newClass1 addLocalMethodFromSource: 'writeHolahola
	holahola := #chao'
	 selector: #writeHolahola:.
	
	newClass2 addLocalMethodFromSource: 'readHolaFromOutside
	System log: ''reading from outside : '', holahola asString'
	selector: #readHolaFromOutside.
	
	newClass2 addLocalMethodFromSource: 'writeHolaFromOutside
	holahola := 12'
	 selector: #writeHolaFromOutside.
	
	self addBehavior: newClass1.
	self addBehavior: newClass2.
	
	^ self
]
