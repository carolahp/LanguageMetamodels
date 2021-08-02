Trait {
	#name : #TLanguageWithClassVars,
	#category : #LanguageMetamodels
}

{ #category : #transforming }
TLanguageWithClassVars >> ttransform [
	| metaclass |
	metaclass := self classWithRole: #Metaclass.
	self
		assert: (metaclass class instVarNames indexOf: #classVariables) > 0
		description: 'You must use TClassWithClassVars in your ClassModel'.
	metaclass addSlot: 'classVariables'.
	metaclass
		addLocalMethodFromSource:
			'classVariables 
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."
	^ classVariables'
		selector: #classVariables.
	metaclass
		addLocalMethodFromSource:
			'classVariables: aDictionary
	"Sets the dictionary of class variables that I share with my sole instance, or nil if I have none."
	^ classVariables := aDictionary'
		selector: #classVariables:
]
