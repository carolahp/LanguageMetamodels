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
