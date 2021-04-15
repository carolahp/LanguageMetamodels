Class {
	#name : #BaselineOfLanguageMetamodels,
	#superclass : #BaselineOf,
	#category : #BaselineOfLanguageMetamodels
}

{ #category : #baselines }
BaselineOfLanguageMetamodels >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec
			 package: 'LanguageMetamodels' ]
]
