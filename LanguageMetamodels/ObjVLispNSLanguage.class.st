Class {
	#name : #ObjVLispNSLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispNamespaces'
}

{ #category : #'hooks-api' }
ObjVLispNSLanguage class >> classModel [ 
	^ ObjVLispNSClass 
]

{ #category : #'hooks-api' }
ObjVLispNSLanguage class >> customModels [ 
	^ self packageModel 
]

{ #category : #hooks }
ObjVLispNSLanguage >> classNamedExactly: aString [
	| className |
	className := (aString indexOf: $>) > 0
		ifTrue: [ aString ]
		ifFalse: [ 'Kernel>', aString ].
	^ self allClasses at: className asSymbol
]

{ #category : #hooks }
ObjVLispNSLanguage >> defaultPackageName [ 
	^ #Kernel
]

{ #category : #hooks }
ObjVLispNSLanguage >> transform [ 
	| dog animalsPkg petsPkg dog1 |
	self allClasses do: [ :class | class package: self defaultPackage ].
	animalsPkg := self ensurePackageNamed: #Animals.
	petsPkg := self ensurePackageNamed: #Pets.
	
	dog := self newClassNamed: #Dog.
	dog package: animalsPkg.
	self addClass: dog.
	
	dog1 := self newClassNamed: #Dog.
	dog1 package: petsPkg.
	self addClass: dog1
]
