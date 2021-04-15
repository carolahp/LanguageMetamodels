Class {
	#name : #BaselineOfLanguageMetamodels,
	#superclass : #Object,
	#category : #BaselineOfLanguageMetamodels
}

{ #category : #baselines }
BaselineOfLanguageMetamodels >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec baseline: 'PharoBootstrapGeneric' with: [ spec
			repository: 'github://carolahp/PharoBootstrapGeneric' ].
		spec
			 package: 'LanguageMetamodels' ]
]
