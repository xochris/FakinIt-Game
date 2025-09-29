extends Control

@onready var QuestionPanel := $QuestionPanel
@onready var WordPanel := $WordPanel
@onready var AnswerPanel := $AnswerPanel
@onready var RevealPanel := $RevealPanel
@onready var DiscussionPanel := $DiscussionPanel



func _ready() -> void:
	# Start the question phase immediately for this simple flow
	if QuestionPanel and QuestionPanel.has_method("start_game"):
		QuestionPanel.start_game(false)


