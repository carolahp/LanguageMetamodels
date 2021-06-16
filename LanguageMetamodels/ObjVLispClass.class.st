"
I am the metamodel of a class in ObjVLisp.
"
Class {
	#name : #ObjVLispClass,
	#superclass : #ExplicitMetaclassesAugmentedClass,
	#category : #'LanguageMetamodels-ObjVLisp'
}

{ #category : #binding }
ObjVLispClass >> bindingOf: varName [ 
	| aSymbol |
	aSymbol := varName asSymbol.

	^ (self innerBindingOf: aSymbol) ifNil: [
		 self environment bindingOf: aSymbol
	]
]
