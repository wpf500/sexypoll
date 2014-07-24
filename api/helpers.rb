#
# General helpers
#

# Require all files in a given subdirectory
def require_from_directory(directory)
  Dir[File.join(File.dirname(__FILE__), directory, '*')].each {|file| require file }
end

def example_quiz
    {
      questions: [
        {
          question: "How old are you?",
          answers: ["16-20", "20-25"],
          type: "single"
        }
      ]
    }
end

def fetch_model(name)
  name.titlecase.constantize
end
