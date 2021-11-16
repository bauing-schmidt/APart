"
The following comment was copied from the original comments of ReportConfirmationYesNo

==========================================================


"
Class {
	#name : #APReportConfirmationYesNo,
	#superclass : #APConfirmationYesNo,
	#instVars : [
		'report',
		'value'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APReportConfirmationYesNo >> defaultPromptSelector [

	^#reportConfirmationYesNo:
]

{ #category : #accessing }
APReportConfirmationYesNo >> report [

	^report
]

{ #category : #accessing }
APReportConfirmationYesNo >> report: anObject [

	report := anObject
]

{ #category : #accessing }
APReportConfirmationYesNo >> value [
	^ value
]

{ #category : #accessing }
APReportConfirmationYesNo >> value: anObject [
	value := anObject
]
