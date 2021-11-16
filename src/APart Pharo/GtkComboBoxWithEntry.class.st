Class {
	#name : #GtkComboBoxWithEntry,
	#superclass : #GtkComboBoxText,
	#category : #'APart Pharo'
}

{ #category : #'instance creation' }
GtkComboBoxWithEntry class >> new [

	^ self comboBoxTextNewWithEntry initialize
]
