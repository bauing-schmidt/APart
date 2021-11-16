"
I subclass `APartNumericPatternFormatter` in order to let the number formatting task be specific for dealing with file sizes.
"
Class {
	#name : #APartFileSizeNumericPatternFormatter,
	#superclass : #APartNumericPatternFormatter,
	#category : #'APart Localization'
}

{ #category : #formatting }
APartFileSizeNumericPatternFormatter >> format: aNumber [
	| association fileSizes formatted positiveResiduals |
	fileSizes := locale fileSizes.
	positiveResiduals := fileSizes
		select: [ :anAssoc | aNumber // (10 ** anAssoc key) > 0 ].
	association := positiveResiduals at: 1 ifAbsent: [ fileSizes last ].
	formatted := super
		format: (aNumber / (10 ** association key)) asFloat.
	^ formatted copyReplaceAll: 's' with: association value
]
