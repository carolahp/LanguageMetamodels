"
ObjVLisp minimum. 
Used a base to develop multiple variants.
It implements explicit metaclasses, single inheritance, instance variables, and the same variable scope for literals and globals than Pharo.
"
Class {
	#name : #ObjVLispMinLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-ObjVLispMin'
}

{ #category : #'hooks-api' }
ObjVLispMinLanguage class >> classModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMinClass  
]

{ #category : #roles }
ObjVLispMinLanguage >> customClassRoles [
	^ { #ProtoObject -> #Object }
]

{ #category : #hooks }
ObjVLispMinLanguage >> firstMetaclasses [
	^{self classClass}
]

{ #category : #hooks }
ObjVLispMinLanguage >> transform [ 
	| metaclass instvars |
	metaclass := self classClass.
	instvars := metaclass allInstVarNames.
	metaclass class allModelInstVarNames do: [ :name |
		(instvars includes: name) ifFalse: [ metaclass addSlot: name ] ] .
	metaclass addLocalMethodFromSource: 'name
	^ name' selector: #name.
	metaclass addLocalMethodFromSource: 'name: aSymbol
	name := aSymbol' selector: #name:.
	
]
