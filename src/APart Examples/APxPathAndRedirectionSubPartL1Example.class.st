"
APxPathAndRedirectionSubPartL1Example a sub view to be used attached to an APxPathAndRedirectionSubPartL1 interface.
"
Class {
	#name : #APxPathAndRedirectionSubPartL1Example,
	#superclass : #APartPresenter,
	#instVars : [
		'subView'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #'interface specs' }
APxPathAndRedirectionSubPartL1Example class >> windowSpec_compressed [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec_compressed"

	<resource: #canvas>
	^ #('#{VWQR:UI.FullSpec}' #window: #('#{VWQR:UI.WindowSpec}' #label: 'Unbenannte Leinwand' #min: #('#{VWQR:Core.Point}' 157 135) #max: #('#{VWQR:Core.Point}' 157 135) #bounds: #('#{VWQR:Graphics.Rectangle}' 1253 671 1410 806)) #component: #('#{VWQR:UI.SpecCollection}' #collection: #(#('#{VWQR:UI.CheckBoxSpec}' #layout: #('#{VWQR:Graphics.LayoutOrigin}' 8 0 106 0) #name: #enabled #model: #enabled #label: 'L1 Enabled') #('#{VWQR:UI.InputFieldSpec}' #layout: #('#{VWQR:Graphics.LayoutFrame}' 9 0 27 0 139 0 49 0) #name: #clickDate #model: #clickDate #type: #date) #('#{VWQR:UI.ActionButtonSpec}' #layout: #('#{VWQR:Graphics.LayoutFrame}' 93 0 106 0 145 0 126 0) #name: #click #model: #click #label: 'Click' #defaultable: true) #('#{VWQR:UI.LabelSpec}' #layout: #('#{VWQR:Graphics.LayoutOrigin}' 6 0 4 0) #name: #Label2 #label: 'Click Date') #('#{VWQR:UI.InputFieldSpec}' #layout: #('#{VWQR:Graphics.LayoutFrame}' 9 0 72 0 139 0 94 0) #name: #'attachedObject name' #model: #'attachedObject name') #('#{VWQR:UI.LabelSpec}' #layout: #('#{VWQR:Graphics.LayoutOrigin}' 11 0 50 0) #name: #Label3 #label: 'Attached'))))
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL1Example >> initialize [

	super initialize.
	subView := APxPathAndRedirectionSubPartL2Example asSubViewOn: self
				subInterface: (self partInterface subInterfaceAtPath: #(#partL2))
]
