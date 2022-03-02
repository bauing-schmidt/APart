Class {
	#name : #APMaTest3,
	#superclass : #APartWithForm,
	#instVars : [
		'name',
		'surname'
	],
	#category : #'Apart-Magritte'
}

{ #category : #accessing }
APMaTest3 >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed: #( name surname )
]

{ #category : #accessing }
APMaTest3 >> initializeDefaultValues [

	<generated>
	
]

{ #category : #accessing }
APMaTest3 >> initializeValues [

	<generated>
	self initializeDefaultValues
]

{ #category : #accessing }
APMaTest3 >> name [

	<generated>
	^ name
]

{ #category : #accessing }
APMaTest3 >> name: anObject [

	<generated>
	name := anObject
]

{ #category : #'magritte descriptions' }
APMaTest3 >> nameDescription [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 112 129 47 57 118 37 58 39 233 16 96 228 135 10 132 166 ));
		  aspect: (MAAspectAccessor aspectName: #name);
		  label: 'Name';
		  placeholder: 'asdf';
		  yourself
]

{ #category : #accessing }
APMaTest3 >> surname [

	<generated>
	^ surname
]

{ #category : #accessing }
APMaTest3 >> surname: anObject [

	<generated>
	surname := anObject
]

{ #category : #'magritte descriptions' }
APMaTest3 >> surnameDescription [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 127 71 219 46 178 82 183 28 57 77 179 106 182 202 238 58 ));
		  aspect: (MAAspectAccessor aspectName: #surname);
		  label: 'Surname';
		  priority: 10;
		  placeholder: 'Pharo';
		  yourself
]
