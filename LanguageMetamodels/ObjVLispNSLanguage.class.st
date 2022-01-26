"
ObjVLisp with static scope for class names, where packages play the role of ""namespaces"". 
Classes are visible only from other classes within its same package.
Packages are first class objects.
To access a class from an external package, you can send the message #> to a package with the name of the class you want to reference. 
Example: (Kernel>#Point) returns the class Point in package Kernel. 

The system allows the existence of classes with the same name as far as they belong to different packages.
"
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
ObjVLispNSLanguage class >> customFirstClassModels [ 
	^ {self packageModel}
]

{ #category : #'hooks-api' }
ObjVLispNSLanguage class >> packageModel [
	^ ObjVLispNSPackage
]

{ #category : #hooks }
ObjVLispNSLanguage >> bindingOf: aSymbol [
	(self globalVariableNamed: aSymbol)
		ifNil: [ (self packageNamed: aSymbol ifAbsent: [nil]) ifNil: [ ^ nil ] ].

	^ self newGlobalBindingFor: aSymbol
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
	super transform.
	self transformPackageClass. 
	self transformDemoClasses
]

{ #category : #hooks }
ObjVLispNSLanguage >> transformDemoClasses [
	| dog animalsPkg petsPkg dog1 |
	self allClasses do: [ :class | class package: self defaultPackage ].
	animalsPkg := self ensurePackageNamed: #Animals.
	petsPkg := self ensurePackageNamed: #Pets.
	
	dog := self newClassNamed: #Dog.
	dog package: animalsPkg.
	self addClass: dog.
	
	dog1 := self newClassNamed: #Dog.
	dog1 package: petsPkg.
	self addClass: dog1.
	
	dog1 addLocalMethodFromSource: 'accessArrayClass
	| logger |
	logger := Kernel>#System.
	logger log: (Kernel>#Array) name asString' 
	selector: #accessArrayClass
]

{ #category : #hooks }
ObjVLispNSLanguage >> transformPackageClass [
	| classPackage |
	classPackage := self classWithRole: #Package.
	self assert: (classPackage slotNamed: #classesDict) isNotNil.
	self assert: (classPackage slotNamed: #name) isNotNil.
	classPackage
		addLocalMethodFromSource:
			'> aSymbol
	^ classesDict at: aSymbol ifAbsent: [ nil ]	'
		selector: #>.
	classPackage
		addLocalMethodFromSource:
			'name
	^ name	'
		selector: #name.
	classPackage
		addLocalMethodFromSource:
			'asString
	^ name	'
		selector: #asString
]
