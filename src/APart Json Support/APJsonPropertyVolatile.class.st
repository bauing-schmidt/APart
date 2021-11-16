"
I am a variant of a property that can hold a value in an APJsonObject that will not be printed on #printJsonOn:.
To avoid potential conflicts with normal property names, a volatile property always uses a Symbol as key (see APJsonObject>>at:putVolatile:).

"
Class {
	#name : #APJsonPropertyVolatile,
	#superclass : #APJsonProperty,
	#category : #'APart Json Support'
}

{ #category : #API }
APJsonPropertyVolatile >> isVolatile [

	^true
]

{ #category : #API }
APJsonPropertyVolatile >> printJsonIncludingNilOn: aStream [
	"Ein Property dieser Klasse wird nicht in den Stream übernommen und wird daher nie persistent."
]
