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
	^ {self packageModel}
]

{ #category : #'hooks-api' }
ObjVLispNSLanguage class >> packageModel [
	^ ObjVLispNSPackage
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
	self addClass: dog1
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
