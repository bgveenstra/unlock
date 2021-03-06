class Message < ActiveRecord::Base
		# validates
		validates :content, :presence => true, :length => { :maximum => 250 }

		EMOTIONS = [
			"smile", "despressed", "like", "dull", "proud", "cry", "shy", "shut_up",
			"nap", "big_cry", "awkward_red", "angry", "naughty", "snag", "surprise", "bad",
			"cool", "awkward", "scream", "vomit", "giggle", "lovely", "who_cares", "zhuai",
			"hungry", "sleepy", "scared", "sweat", "simper", "solider", "strive", "shout",
			"questionaire", "hiss", "dizzy", "impantient", "be_bombed", "skull", "hit_head", "bye",
			"sweat", "pick_nose", "applause", "embarrassed", "cheeky_grin", "not_worth_left", "not_worth_right", "yawn", 
			"contempt", "grievance", "sad", "sinister_smile", "kiss", "startle", "pitiful", "chopper",
			"watermelon", "beer", "basketball", "pingpong", "coffee", "rice", "pig", "flower",
			"wither", "love", "heart", "borken_heart", "cake", "light", "bomb", "sword", 
			"football", "insect", "shit", "moon", "sun", "gift", "hug", "good", 
			"Lously", "agree", "Yeal", "greet", "come", "fist", "little_finger",
			"love_you", "no", "ok"
		]
		
		# The created time of the message
		def send_time
		  self.created_at.strftime("%Y-%m-%d %H:%M:%d")
		end

		# convert the marks to html tags
		def html_content
			return "" if content.blank? 
			str = content.gsub(/<(\s*)(\w+)(\s*)>/){ |s| "<\#{$1}>" }
			str = str.gsub(/<\/(\s*)(\w+)(\s*)>/){ |s| "<\/>" }
			str = str.gsub(/\r\n/, "<br/>") 
			str = str.gsub(/(\s)/, "&nbsp;")
			str = str.gsub(/\[bold\]/, "<b>")
			str = str.gsub(/\[-bold\]/, "</b>")
			str = str.gsub(/\[italic\]/, "<i>")
			str = str.gsub(/\[-italic\]/, "</i>")
			str = str.gsub(/\[color:(#.{6})\]/){ |s| "<span style=\"color:#{$1}\">" }
			str = str.gsub(/\[-color\]/, "</span>")
			str = str.gsub(/\[(\w+)\]/) do |s|
				emotion = EMOTIONS.index($1)
				emotion.nil? ? "[#{$1}]": "<img src=\"/assets/emotions/#{emotion}.gif\" />" 
			end
			return str
		end
end
