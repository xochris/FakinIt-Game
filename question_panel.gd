extends Control

var question_label: RichTextLabel = null
var question_mark_button: Button = null

var current_is_imposter: bool = false

# Questions (player, imposter)
var questions: Array = [
	["How many days would you survive a zombie apocalypse?",
	"How many days could you last going vegan?"],

	["How many days could you last going vegan?",
	"Choose a number between 1-infinity"],

	["What reality show would you go on to win?",
	"What reality show do you enjoy watching?"],
	
	["Name a city you've never visited.",
	"What's your favorite city you've visited?"],

	["If the world was ending, what continent would sink first?",
	"Name a continent you would want to live on."],

	["If you could speak any language, what would it be?",
	"If you could erase one language in the world, what would it be?"],

	["How many dates before kissing the person?",
	"Choose a number between 1-10"],

	["What age should you stop clubbing?",
	"What's a good age to have kids?"],

	["What's a good age to have kids?",
	"Choose a number between 15-75"],

	["What animal could you take in a fight?",
	"What animal would make a good pet?"],

	["What's the best pet to give a kid?",
	"Your favorite pet as a child?"],

	["What would be your dream job?",
	"What job is useless, in your eyes?"],

	["What's your pump up song?",
	"What's your go-to karaoke song?"],

	["What's your go-to karaoke song?",
	"What's an overrated song?"],

	["What's an overrated song?",
	"What's your pump up song?"],

	["How many days could you go without eating?",
	"Choose a number between 1-30"],

	["Who do you call first, if you won the lottery?",
	"What friend never picks up your calls?"],

	["If you could have any superpower, what would it be?",
	"What's a useless superpower?"],

	["What would be your last meal?",
	"What fast food restaurant meal do you order the most?"],

	["What's your favorite holiday?",
	"What holiday is the most overrated?"],

	["What holiday is the most overrated?",
	"Choose a random holiday (good luck lol)"],

	["If you could go back in time, what decade would you go to?",
	"What decade would be the worst to live in?"],

	["What's your favorite pizza topping?",
	"What's the worst pizza topping?"],

	["What's the weirdest topping that could go on a pizza?",
	"What pizza topping do you hate?"],

	["What skill would you learn if you had unlimited time?",
	"What's a hidden skill you have no one knows about?"],

	["What's your biggest irrational fear?",
	"What common fear do you think is silly?"],

	["How many countries have you visited?",
	"Choose a number between 0-50"],

	["If you were a household chore, what would you be?",
	"What household chore do you hate the most?"],

	["If you started a Youtube channel, what would it be about?",
	"What type of content do you watch the most on YouTube?"],

	["What's an underated candy?",
	"What candy do you take to the movies?"],

	["If you had a chance to go pro in any sport, what would it be?",
	"What sport do you think is hardest to play?"],

	["If you had to give up one of your senses, which would it be?",
	"Which sense is the hardest to live without?"],

	["Arguably, who is the best disney princess?",
	"What disney princess has the worse movie?"],

	["Name one item you would bring to a deserted island.",
	"What is an item you could not live without?"],

	["Name one item you would want in a zombie apocalypse.",
	"What's the worse gift to recieve."],

	["If you were a Pokemon, what type would you be?",
	"Choose between water or ice."],

	["If you had one million dollars right now, what's the first thing you buy?",
	"What was the first thing you bought with your first paycheck?"],

	["What website do you visit the most often?",
	"What website would you ban your kid from visiting?"],

	["What's the worst ice cream flavor?",
	"Weirdest ice cream flavor you've ever tried?"],

	["Which fruit is the best?",
	"If you were a fruit, what kind of fruit would you be?"],

	["If you became a substitute teacher, what class would you teach?",
	"What class did you hate the most in school?"]

]

var current_question_index: int = -1

func _ready() -> void:
	# Keep this panel hidden until the game controller calls start_game()
	visible = false

	# Try to locate the RichTextLabel under QuestionLabel. Your RichTextLabel
	# may have a different name (for example 'Display_Question'), so we search
	# the children to find the first RichTextLabel instance.
	if has_node("QuestionLabel"):
		var qnode = get_node("QuestionLabel")
		# shallow search first
		for child in qnode.get_children():
			if child is RichTextLabel:
				question_label = child
				break
		# deep search fallback
		if question_label == null:
			for child in qnode.get_children():
				var found := _find_richtext_in_tree(child)
				if found:
					question_label = found
					break

	# Do NOT auto-connect the QuestionMark here — you said the parent handles it.
	if has_node("QuestionMark"):
		question_mark_button = get_node("QuestionMark")

	randomize()

	print("[question_panel] ready — question_label:", question_label, " question_mark_button:", question_mark_button)

	# Uncomment this for quick local testing (auto-start)
	# start_game(false)


func pick_random_question() -> Array:
	# choose a random index into the questions array
	current_question_index = randi() % questions.size()
	return questions[current_question_index]


func _find_richtext_in_tree(node: Node) -> RichTextLabel:
	# Recursively search for a RichTextLabel under `node`.
	if node is RichTextLabel:
		return node
	for child in node.get_children():
		var found := _find_richtext_in_tree(child)
		if found:
			return found
	return null


func start_game(is_imposter: bool = false) -> void:
	# Called by the game controller when the game starts
	current_is_imposter = is_imposter
	pick_random_question()
	show_question(is_imposter)


func show_question(is_imposter: bool = false) -> void:
	# Display the currently picked question (or pick one if none chosen)
	if current_question_index == -1:
		pick_random_question()

	var pair: Array = questions[current_question_index]
	var text: String = pair[1] if is_imposter else pair[0]

	if question_label:
		question_label.bbcode_text = text
	else:
		push_error("RichTextLabel not found at QuestionLabel/RichTextLabel")

	visible = true


func _on_question_mark_pressed() -> void:
	# Re-show whatever question the user last saw
	show_question(current_is_imposter)
