"
APartDialog dient als Interface modale Dialoge mit bekanntem Aufbau. Die eigentliche Ausführung des Dialogs wird an den #dialogSupplier delegiert. 
"
Class {
	#name : #APartDialog,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'APart Pharo'
}

{ #category : #'choose from list' }
APartDialog class >> chooseMany: messageString fromList: list sorted: aBoolean [
	"IMSDialog chooseMany: 'Wählen Sie einen Buchstaben aus'
			fromList: #('F' 'E' 'C' 'D' 'A' 'B') 
			sorted: true"

	^self
		chooseMany: messageString
		fromList: list
		sorted: aBoolean
		wLabel: nil
]

{ #category : #'multiple choice' }
APartDialog class >> confirm: messageString [
	"Stellt dem Nutzer eine Ja/Nein-Frage"
	"IMSDialog confirm: 'Gefällt Ihnen dieses Fenster?'"

	^(self questionYesNo: messageString wLabel: nil) = #yes
]

{ #category : #'instance creation' }
APartDialog class >> for: aClient [

	^ self new client: aClient
]

{ #category : #messages }
APartDialog class >> message: messageString [
	"Filed out as: '2O5SXQ.ST' "
	"Last change: Frank Winkler (13 February 1995 8:58:39 am) " 
	"Creator: Frank Winkler (25 January 1995 4:47:53 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Gibt dem Nutzer eine Mitteilung aus"

	"IMSDialog message: 'Das ist eine Nachricht an den Nutzer'"


	^self message: messageString wLabel: nil
]

{ #category : #messages }
APartDialog class >> messageWithTimeout: messageString [
	"Gibt dem Nutzer eine Mitteilung aus"
	"IMSDialog messageWithTimeout:  'Das ist eine Nachricht an den Nutzer'"

	^self messageWithTimeout: messageString wLabel: nil
]

{ #category : #'multiple choice' }
APartDialog class >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue [
	"Filed out as: '2O5T5Q.ST' "
	"Last change: Frank Winkler (13 February 1995 9:03:27 am) " 
	"Creator: Frank Winkler (26 January 1995 9:46:24 am) " 
	"Copyright © 1995 IMS GmbH"
	"Stellt dem Nutzer eine Frage mit mehreren Antwortmöglichkeiten"

	"IMSDialog multipleChoice: 'Bitte wählen Sie aus' 
			labels: #('A' 'B' 'C' 'D' 'E') 
			values: #(#A #B #C #D #E)  
			default: #C "

	^self multipleChoice: messageString 
			labels: labelArray 
			values: valueArray 
			default: defaultValue 
			wLabel: nil
]

{ #category : #'string requests' }
APartDialog class >> multipleRequest: messageStrings [
	"Filed out as: '2O7UXR.ST' "
	"Last change: Frank Winkler (14 February 1995 11:37:04 am) " 
	"Creator: Frank Winkler (14 February 1995 11:36:38 am) " 
	"Copyright © 1995 IMS GmbH"
	"Einfachster Eingabedialog mit mehreren Eingabefeldern"

	"^IMSDialog multipleRequest: #('Vorname' 'Nachname' 'Ort' ) "

	^self multipleRequest: messageStrings wLabel: nil
]

{ #category : #'string requests' }
APartDialog class >> multipleRequest: messageStrings initialAnswers: initialAnswers [
	"Filed out as: '2O7UJ6.ST' "
	"Last change: Frank Winkler (14 February 1995 11:28:19 am) " 
	"Creator: Frank Winkler (14 February 1995 11:27:50 am) " 
	"Copyright © 1995 IMS GmbH"
	"Eingabedialog für mehrere Eingabestrings"

	"^IMSDialog
			multipleRequest: #('Vorname' 'Nachname' 'Paßwort' ) 
			initialAnswers: #('Frank' nil #password ) "


	^self multipleRequest: messageStrings 
			initialAnswers: initialAnswers 
			wLabel: nil
]

{ #category : #'string requests' }
APartDialog class >> multipleRequest: messageStrings wLabel: wLabel [
	"Filed out as: '2O7URH.ST' "
	"Last change: Frank Winkler (14 February 1995 11:33:18 am) " 
	"Creator: Frank Winkler (14 February 1995 11:32:36 am) " 
	"Copyright © 1995 IMS GmbH"
	"Eingabedialog mit mehreren Eingabefeldern, aber ohne Vorgabewerte"

	"^IMSDialog
			multipleRequest: #('Vorname' 'Nachname' 'Ort' ) 
			wLabel: 'TEST' "

	^self multipleRequest: messageStrings 
			initialAnswers: Array new
			wLabel: wLabel
]

{ #category : #'simple questions' }
APartDialog class >> questionYesNo: messageString [
	"Filed out as: '2O5TAP.ST' "
	"Last change: Frank Winkler (13 February 1995 9:06:26 am) " 
	"Creator: Frank Winkler (26 January 1995 8:13:59 am) " 
	"Copyright © 1995 IMS GmbH"
	"Stellt dem Nutzer eine Ja/Nein-Frage"

	"IMSDialog questionYesNo: 'Gefällt Ihnen dieses Fenster?'"

	^self questionYesNo: messageString wLabel: nil
]

{ #category : #'simple questions' }
APartDialog class >> questionYesNoCancel: messageString [
	"Filed out as: '2O5TKP.ST' "
	"Last change: Frank Winkler (13 February 1995 9:12:26 am) " 
	"Creator: Frank Winkler (26 January 1995 8:35:11 am) " 
	"Copyright © 1995 IMS GmbH"
	"Stellt dem Nutzer eine Ja/Nein/Abbruch-Frage"

	"IMSDialog questionYesNoCancel: 'Gefällt Ihnen dieses Fenster?'"

	^self questionYesNoCancel: messageString wLabel: nil
]

{ #category : #'string requests' }
APartDialog class >> request: messageString [
	"Filed out as: '2O7WNH.ST' "
	"Last change: Frank Winkler (14 February 1995 12:14:05 pm) " 
	"Creator: Frank Winkler (14 February 1995 12:13:43 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Einfacher Dialog mit einem Eingabefeld, kein Vorgabewert, Standardfenstertitel"

	"^IMSDialog request: 'Name' "

	^self request: messageString wLabel: nil
]

{ #category : #runtime }
APartDialog class >> runtimeCriticalErrorMessage [
	"Filed out as: '3RTTVL.ST' "
	"Last change: Frank Winkler, 25.03.1997, 12:11:46 " 
	"Creator: Frank Winkler, 25.03.1997, 12:01:11 " 
	"Copyright © 1997 IMS GmbH"
	"Uncommented"

	| messageString  labelString |
	messageString := self translate: '' with: 'runtimeCriticalError'.
	labelString := self translate: '' with: 'runtimeCriticalErrorLabel'.
	self message: messageString wLabel: labelString.
]

{ #category : #runtime }
APartDialog class >> runtimeErrorMessage [
	"Filed out as: '3AN60D.ST' "
	"Last change: Frank Winkler, 25.04.1996, 10:19:26 " 
	"Creator: Frank Winkler, 25.04.1996, 10:17:19 " 
	"Copyright © 1996 IMS GmbH"
	"Gibt im Laufzeitsystem eine Fehlermeldung aus"

	| messageString  labelString |
	messageString := self translate: '' with: 'runtimeError'.
	labelString := self translate: '' with: 'runtimeErrorLabel'.
	self message: messageString wLabel: labelString.
]

{ #category : #translation }
APartDialog class >> translate: aString with: aKey [

	[^(self perform: (aKey methodNameWithPrefix: 'L')) asString]
		on: MessageNotUnderstood
		do: [:ex | ^aString]
]

{ #category : #'choose from list' }
APartDialog >> choose: messageString fromLabels: list values: listValues sorted: aBoolean wLabel: aLabel [
	| sortCollection newList newListValues |
	aBoolean
		ifTrue: [ sortCollection := SortedCollection new.
			1 to: list size do: [ :i | 
				sortCollection
					add: ((APartPlatform current associationClassForDialogs) key: (list at: i) value: (listValues at: i)) ].
			newList := OrderedCollection new.
			newListValues := OrderedCollection new.
			1 to: sortCollection size do: [ :i | 
				newList add: (sortCollection at: i) key.
				newListValues add: (sortCollection at: i) value ] ]
		ifFalse: [ newList := list.
			newListValues := listValues ].

	^ APartPlatform current chooseFromList: newList values: newListValues part: self label: aLabel messageString: (messageString translateFor: client locale)
]

{ #category : #'simple questions' }
APartDialog >> chooseMany: messageString fromLabels: list values: listValues sorted: aBoolean wLabel: aLabel [ 
	"Fordert den Nutzer zur Auswahl aus einer Liste auf"

	"IMSDialog chooseMany: 'Wählen Sie einen Buchstaben aus'
			fromLabels: #('A' 'B' 'C' 'D' 'E' 'F') 
			values: #(#A #B #C #D #E #F)  
			sorted: true
			wLabel: 'Testauswahl' "		

	| theLabel sortCollection newList newListValues |

	theLabel := aLabel.
	((theLabel isNil) or: [theLabel = ''])
		ifTrue:	[theLabel := 'IMS - Auswahl'.
				theLabel := APartPlatform current translate: theLabel with: 'selection' in: self.
				].
	aBoolean
		ifTrue:	[sortCollection := SortedCollection new.
				1 to: list size do:
					[:i |	sortCollection add: ((APartPlatform current associationClassForDialogs) key: (list at: i) value: (listValues at: i)).].
				newList := OrderedCollection new.
				newListValues := OrderedCollection new.
				1 to: sortCollection size do:
					[:i |	newList add: (sortCollection at:i) key.
						newListValues add: (sortCollection at: i) value.
					]. 
				]
		ifFalse:	[newList := list.
				newListValues := listValues.
				].
			
	^ APartPlatform current chooseManyFromList: newList values: newListValues part: self label: theLabel messageString: messageString
]

{ #category : #'simple questions' }
APartDialog >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil [ 

	^ APartPlatform current chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil dialog: self
]

{ #category : #'simple questions' }
APartDialog >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean wLabel: wLabel for: aVisualOrNil [ 

	^ APartPlatform current chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil wLabel: wLabel dialog: self
]

{ #category : #'simple questions' }
APartDialog >> chooseReport: messageString labels: labels values: values default: defaultValue for: aVisualOrNil [ 
	"Ask the user a question, expecting the question to be a rather long string.
	The question is displayed in a scrollable text editor rather than with a simple label.
	Let the user pick from a row of buttons made up
	to match the labels collection.  Return the response from the corresponding
	item from the values collection. aVisualOrNil, if not nil, may be either a VisualPart or a
	ScheduledWindow.  It controls the look and feel and color choices
	used by the dialog, and supplies the dialog's master window, which
	is used by some window systems to create a visual connection between
	the dialog and the window that created it."

	^self
		chooseReport: messageString
		labels: labels
		values: values
		default: defaultValue
		equalize: true
		for: aVisualOrNil
]

{ #category : #'simple questions' }
APartDialog >> chooseReport: messageString labels: labels values: values default: defaultValue wLabel: wLabel for: aVisualOrNil [ 
	"Ask the user a question, expecting the question to be a rather long string.
	The question is displayed in a scrollable text editor rather than with a simple label.
	Let the user pick from a row of buttons made up
	to match the labels collection.  Return the response from the corresponding
	item from the values collection. aVisualOrNil, if not nil, may be either a VisualPart or a
	ScheduledWindow.  It controls the look and feel and color choices
	used by the dialog, and supplies the dialog's master window, which
	is used by some window systems to create a visual connection between
	the dialog and the window that created it."

	^self
		chooseReport: messageString
		labels: labels
		values: values
		default: defaultValue
		equalize: true
		wLabel: wLabel 
		for: aVisualOrNil
]

{ #category : #accessing }
APartDialog >> client [
	^ client
]

{ #category : #accessing }
APartDialog >> client: anObject [
	client := anObject
]

{ #category : #'simple questions' }
APartDialog >> errorMessage: messageString wLabel: wLabel [

	^ APartPlatform current errorMessage: messageString wLabel: wLabel dialog: self
]

{ #category : #accessing }
APartDialog >> locale [
	^client ifNotNil: [client locale]
]

{ #category : #'simple questions' }
APartDialog >> message: messageString wLabel: wLabel [

	^ APartPlatform current message: messageString wLabel: wLabel dialog: self
]

{ #category : #'simple questions' }
APartDialog >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue [
	"Filed out as: '2O5T5Q.ST' "
	"Last change: Frank Winkler (13 February 1995 9:03:27 am) " 
	"Creator: Frank Winkler (26 January 1995 9:46:24 am) " 
	"Copyright © 1995 IMS GmbH"
	"Stellt dem Nutzer eine Frage mit mehreren Antwortmöglichkeiten"

	"IMSDialog multipleChoice: 'Bitte wählen Sie aus' 
			labels: #('A' 'B' 'C' 'D' 'E') 
			values: #(#A #B #C #D #E)  
			default: #C "

	^self multipleChoice: messageString 
			labels: labelArray 
			values: valueArray 
			default: defaultValue 
			wLabel: nil
]

{ #category : #'simple questions' }
APartDialog >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue wLabel: wLabel [
	
	^ APartPlatform current multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue wLabel: wLabel dialog: self
]

{ #category : #'simple questions' }
APartDialog >> questionYesNo: messageString wLabel: wLabel labelYes: aYesLabel labelNo: aNoLabel [

	| theLabel yesLabel noLabel |
	theLabel := wLabel.
	(theLabel isNil or: [theLabel = ''])
		ifTrue: 
			[theLabel := 'IMS - Frage'.
			theLabel := APartPlatform current translate: theLabel with: 'question' in: self].
	yesLabel := aYesLabel 
				ifNil: [APartPlatform current translate: 'Yes' with: 'bYes' in: self]
				ifNotNil: [ aYesLabel translateFor: self locale].
	noLabel := aNoLabel
				ifNil: [APartPlatform current translate: 'No' with: 'bNo' in: self]
				ifNotNil: [ aNoLabel translateFor: self locale].

	^ APartPlatform current questionYesNo: messageString wLabel: theLabel labelYes: yesLabel labelNo: noLabel dialog: self
]

{ #category : #'simple questions' }
APartDialog >> request: messageString initialAnswer: initialAnswer wLabel: wLabel [
	
	^ APartPlatform current request: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: self
]

{ #category : #'simple questions' }
APartDialog >> requestMultiline: messageString initialAnswer: initialAnswer wLabel: wLabel [
	
	^ APartPlatform current requestMultiline: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: self
]

{ #category : #'APart Pharo' }
APartDialog >> specApplication [
		
	^ self client 
		ifNil: [ SpApplication new useBackend: #Gtk]
		ifNotNil: [ self client ownerDo: [ :theOwner | theOwner application ] ]
]
