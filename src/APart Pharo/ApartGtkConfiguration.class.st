Class {
	#name : #ApartGtkConfiguration,
	#superclass : #SpGtkConfiguration,
	#category : #'APart Pharo'
}

{ #category : #configuring }
ApartGtkConfiguration >> configureWindows: anApplication [

	self installTheme: 'Adwaita'
]
