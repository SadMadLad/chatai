import { defineStore } from "pinia";
import { reactive } from "vue";

const useQuizStore = defineStore("quiz", () => {
  const quizzes = reactive({
    quiz_undertaking: {
      selected_options: [],
    },
  });

  function initializeQuizzesArray(questions) {
    resetQuizState();

    if (questions) {
      questions.forEach((question) => {
        const quizHash = {
          id: question.id,
          selected: question.multiple_answers ? [] : null,
        };
        quizzes.quiz_undertaking.selected_options.push(quizHash);
      });
    }
  }

  function addSelectedOption(selected, index) {
    quizzes.quiz_undertaking.selected_options[index].selected = selected;
  }

  function getSelected(index) {
    return quizzes.quiz_undertaking.selected_options[index].selected;
  }

  function getAllSelectedOptions() {
    return { ...quizzes };
  }

  function resetQuizState() {
    quizzes.quiz_undertaking.selected_options = [];
  }

  return {
    addSelectedOption,
    getAllSelectedOptions,
    getSelected,
    initializeQuizzesArray,
    quizzes,
  };
});

export { useQuizStore };
