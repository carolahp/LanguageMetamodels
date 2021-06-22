"
Download my Language Definitions from https://github.com/carolahp/PharoCandleSrc/tree/ownerlanguage
and set them in the constructor 
OwnerLanguage 
	newFromModel: pathToDefinitions 
	withName: #Owner
	withEntryPoint: 'PCSystem log: ''hello from Owner!''. PCSystem quit'.
"
Class {
	#name : #OwnerLanguage,
	#superclass : #CandleLanguage,
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #hooks }
OwnerLanguage >> transform [
	| required insert |
	self test.
	self halt.
	(self classWithRole: 'ProtoObject')
		recursivellyDo: [ :class | 
			insert := class acceptsNewSlots.
			class allSubclasses
				do: [ :subclass | 
					insert := insert and: subclass acceptsNewSlots.
					required := subclass template
						ifNil: [ #() ]
						ifNotNil: [ subclass template modelAllInstVarNames ].
					insert := insert and: (required endsWith: class allSlots) ].
			insert
				ifTrue:
					[ class slotNamed: #owner ifAbsent: [ class addSlot: #owner ] ] ]
		to: [ :c | c subclasses ].
	self test
]
