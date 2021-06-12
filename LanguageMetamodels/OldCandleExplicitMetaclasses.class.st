Class {
	#name : #OldCandleExplicitMetaclasses,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #'hooks-api' }
OldCandleExplicitMetaclasses class >> classMetaclass [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ExplicitMetaclassesAugmentedClass 
]

{ #category : #hooks }
OldCandleExplicitMetaclasses >> entryPointCode [
	^ 'System quit'
]

{ #category : #hooks }
OldCandleExplicitMetaclasses >> hookSetSpecialObjectsArray: anEP2RemoteArray [ 
	^nil
]

{ #category : #hooks }
OldCandleExplicitMetaclasses >> initializeSpecialObjectsArray [
	^ nil
]
