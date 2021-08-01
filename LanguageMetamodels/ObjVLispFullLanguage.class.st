Class {
	#name : #ObjVLispFullLanguage,
	#superclass : #ObjVLispMinLanguage,
	#traits : 'TLanguageWithClassVars',
	#classTraits : 'TLanguageWithClassVars classTrait',
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
