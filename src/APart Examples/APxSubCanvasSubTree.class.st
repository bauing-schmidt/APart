"
APxSubCanvasSubTree ist ein SubCanvas für das Beispiel APxSubCanvasPartSwitchtExample.
"
Class {
	#name : #APxSubCanvasSubTree,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-SubCanvasPartSwitch'
}

{ #category : #'interface specs' }
APxSubCanvasSubTree class >> windowSpecGeneric [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpecGeneric"

	<resource: #canvas>
	^ #('#{VWQR:UI.FullSpec}' #window: #('#{VWQR:UI.WindowSpec}' #label: 'Unbenannte Leinwand' #min: #('#{VWQR:Core.Point}' 20 20) #max: #('#{VWQR:Core.Point}' 0 0) #bounds: #('#{VWQR:Graphics.Rectangle}' 995 543 1283 897)) #component: #('#{VWQR:UI.SpecCollection}' #collection: #(#('#{VWQR:UI.TreeViewSpec}' #layout: #('#{VWQR:Graphics.LayoutFrame}' 10 0 10 0 -10 1 -10 1) #name: #selectionInTree #model: #selectionInTree #useModifierKeys: true #selectionType: #highlight))))
]
