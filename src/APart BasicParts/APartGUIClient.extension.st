Extension { #name : #APartGUIClient }

{ #category : #'*APart BasicParts-interface opening callbacks' }
APartGUIClient >> sliderStart: aStart stop: aStop step: aStep forSteppedSliderKey: aSteppedSliderKey [

	self ownerDo: 
			[:o |
			o
				sliderStart: aStart
				stop: aStop
				step: aStep
				forSteppedSliderKey: aSteppedSliderKey]
]
