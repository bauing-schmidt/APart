Extension { #name : #Timestamp }

{ #category : #'*APart Json Glorp Support' }
Timestamp >> iso8601DateString [

	| s |
	s := WriteStream on: String new.
	self printOn: s.
	^s contents
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> iso8601String [

	^self iso8601DateString , 'T' , self timeWithMillisecondsString
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> printIsoDateOn: s [

	self year printString printZeroPaddedTo: 4 on: s terminateWith: $-.
	self month printString printZeroPaddedTo: 2 on: s terminateWith: $-.
	self day printString printZeroPaddedTo: 2 on: s
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> printJsonOn: aStream [

	self printPlainIso8601On: aStream
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> printPlainIso8601On: s [
	"[ | s ref | ref := '2015-11-23T09:10:55.937'. s := WriteStream on: String new. 
	(self new readFromPlainIso8601: ref) printPlainIso8601On: s. s contents = ref ]
	[ | s ref | ref := '2015-11-23T09:10:55.000'. s := WriteStream on: String new. 
	(self new readFromPlainIso8601: ref) printPlainIso8601On: s. s contents = ref ]"

	self dayMonthYearDo: [:day :month :year | 
		year printString printZeroPaddedTo: 4 on: s terminateWith: $-.
		month printString printZeroPaddedTo: 2 on: s terminateWith: $-.
		day printString printZeroPaddedTo: 2 on: s terminateWith: $T.
	].
	self flag: #todo. "wrong format"
	self printOn: s
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> printTimeWithMillisecondsOn: s [

	self hours printString printZeroPaddedTo: 2 on: s terminateWith: $:.
	self minutes printString printZeroPaddedTo: 2 on: s terminateWith: $:.
	self seconds printString printZeroPaddedTo: 2 on: s terminateWith: $..
	(self milliseconds ifNil: [0]) printString printZeroPaddedTo: 3 on: s
]

{ #category : #'*APart Json Glorp Support' }
Timestamp class >> readFromPlainIso8601: aString [
	"[self readFromPlainIso8601: '2015-11-23']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937Z']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937+01:00']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937-04:00']"

	^self fromString: aString
]

{ #category : #'*APart Json Glorp Support' }
Timestamp >> timeWithMillisecondsString [

	| s |
	s := WriteStream on: (String new: 12).
	self flag: #todo. "wrong format"
	self printOn: s.
	^s contents
]
