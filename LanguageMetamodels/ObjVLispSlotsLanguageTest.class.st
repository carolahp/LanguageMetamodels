Class {
	#name : #ObjVLispSlotsLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> languageModelClass [
	^ ObjVLispSlotsLanguage
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMCreateArray [
	entryPointCode := '
	System log: #() asString.
	System quit'.
	expectedResult := '#()'.

	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMGetPointSlots [
	entryPointCode := '
	System log: Point allSlots asString.
	System quit'.
	expectedResult := '#(x => InstanceVariableSlot y => InstanceVariableSlot )'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMPrintHola [
	entryPointCode := 'System log: ''hola'' asString. System quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMReflectiveSlotRead [
	entryPointCode := '| p |
	p := Point new.
	p x: 42 y: 12.
	Point allSlots do: [:slot |
		System log: (slot read: p) asString
		].
	System quit'.
	expectedResult := '42
12'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMReflectiveSlotWrite [
	entryPointCode := '| p |
	p := Point new.
	(Point slotNamed: #x) write: 42 to: p.
	(Point slotNamed: #y) write: 12 to: p.
	System log: p x asString.
	System log: p y asString.
	System quit'.
	expectedResult := '42
12'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispSlotsLanguageTest >> testInVMWriteAPointSlotsXAndY [
	entryPointCode := '|p|
	p := Point new.
	p x: 1 y: 2.
	System log: p x asString.
	System log: p y asString.
	System quit'.
	expectedResult := '1
2'.

	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
