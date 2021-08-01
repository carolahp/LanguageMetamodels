Class {
	#name : #ObjVLispFullLanguage,
	#superclass : #ObjVLispMinLanguage,
	#traits : 'TLanguageWithClassVars + TLanguageWithSystemDictionary',
	#classTraits : 'TLanguageWithClassVars classTrait + TLanguageWithSystemDictionary classTrait',
	#category : #'LanguageMetamodels-ObjVLispFull'
}

{ #category : #'hooks-api' }
ObjVLispFullLanguage class >> globalModel [
	^ ObjVLispFullGlobal 
]

{ #category : #'hooks-api' }
ObjVLispFullLanguage class >> metaclassModel [
	^ ObjVLispFullClass  
]

{ #category : #traits }
ObjVLispFullLanguage >> languageTraitComposition [
	self flag: 'despues resolver el orden en que se devuelven los traits, segun los requerimientos del lenguage'.
	^ self class traitComposition traits
]

{ #category : #ambiguous }
ObjVLispFullLanguage >> transform [
	((self languageTraitComposition 
		select: [ :t | t includesLocalSelector: #ttransform ])
		flatCollect: [ :t | t methods select: [ :m | m selector = #ttransform ] ])
		do: [ :m | m valueWithReceiver: self arguments: #() ]
]
