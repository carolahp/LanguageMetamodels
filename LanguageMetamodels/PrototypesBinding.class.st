Class {
	#name : #PrototypesBinding,
	#superclass : #EP2CrossCompilerBinding,
	#category : #'LanguageMetamodels-Prototypes'
}

{ #category : #binding }
PrototypesBinding >> binding [ 
	^ EP2GlobalBinding  new
			name: class name; 
			objectSpace: environment objectSpace;
			yourself 
]

{ #category : #binding }
PrototypesBinding >> bindingOf: aString [
	"There are no class variables nor shared pools"
	"Therefore it is a temp or an instance variable"
	self deprecated: 'use binding from object models'.
	^ nil
]

{ #category : #binding }
PrototypesBinding >> innerBindingOf: aString [ 
	"no class variables nor shared pools"
	"If it is a temp or an instance variable"
	^ nil
]
