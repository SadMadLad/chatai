<script setup>
import { defineProps, toRefs, ref, watch } from "vue";
import { useQuizStore } from "@/storage/quiz";

const { addSelectedOption, getSelected } = useQuizStore();

const props = defineProps({
  id: Number,
  index: Number,
  multiple_answers: Boolean,
  question_text: String,
  question_options: Object,
});

const { multiple_answers, index } = toRefs(props);
const selected = ref(getSelected(index.value));

watch(selected, (newSelected) => {
  addSelectedOption(newSelected, index.value);
});
</script>

<template>
  <div>
    {{ question_text }}

    <hr />

    <ul v-if="multiple_answers" class="flex flex-col gap-2.5">
      <li v-for="{ id, option_text } in question_options">
        <input
          type="checkbox"
          :name="id"
          :id="id"
          :value="id"
          v-model="selected"
        /><label :for="id">{{ option_text }}</label>
      </li>
    </ul>
    <ul v-else>
      <li v-for="{ id, option_text } in question_options">
        <input :name="id" type="radio" :value="id" :id="id" v-model="selected" />
        <label :for="id">{{ option_text }}</label>
      </li>
    </ul>
  </div>
</template>
