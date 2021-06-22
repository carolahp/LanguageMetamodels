Class {
	#name : #CandlePackage,
	#superclass : #PackageModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #exporting }
CandlePackage >> asMCSnapshot [
	| definitions |
	definitions := #() asOrderedCollection.
	"adding the package"
	definitions add: self asMCDefinition.
	"adding behaviors"
	definitions
		addAll:
			(((self definedBehaviors reject: #isCandleMetaclass)
				sorted: [ :a :b | a name < b name ]) collect: #asMCDefinition).
	"adding methods"
	
	definitions
		addAll:
			(self definedBehaviors , (self definedBehaviors collect: #metaclass)
				flatCollect: [ :behavior | 
					(behavior localMethods
						reject: [ :each | (each parent instanceSide package = each package) not ])
						collect: [ :method | method asMCDefinition ] ]).
	^ MCSnapshot fromDefinitions: definitions
]
