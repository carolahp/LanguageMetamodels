Class {
	#name : #OwnerMetaclass,
	#superclass : #CandleMetaclass,
	#instVars : [
		'owner'
	],
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #'hooks-api' }
OwnerMetaclass class >> role [ 
	^ #Metaclass
]

{ #category : #accessing }
OwnerMetaclass >> owner [ 
	^ owner
]
