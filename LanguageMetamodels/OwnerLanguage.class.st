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
	self halt.
	(self classWithRole: 'ProtoObject')
		recursivellyDo: [ :c | 
			c acceptsNewSlots
				ifTrue: [ [ c addSlot: #owner ]
						on: SlotDuplicated
						do: #resume ] ]
		to: [ :c | c subclasses ].
	self allClasses
		do: [ :c | 
			c acceptsNewSlots
				ifTrue: [ c addSlot: 'owner' ] ].
	self allClasses
		collect: [ :c | 
			{(c allSlots contains: [ :s | s name = 'owner' ]).
			(c slots collect: #name)} ]
]
