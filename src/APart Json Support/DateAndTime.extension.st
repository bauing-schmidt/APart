Extension { #name : #DateAndTime }

{ #category : #'*APart Json Support' }
DateAndTime >> printJsonOn: s [
	"YYYY-MM-DD hh:mm:ss"
	
	s
		nextPut: $";
		nextPutAll: self asStringYMDHM;
		nextPut: $:.
	self seconds printOn: s base: 10 length: 2 padded: true.
	s nextPut: $".

]
