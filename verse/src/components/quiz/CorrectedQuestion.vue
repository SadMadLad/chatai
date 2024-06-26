<script setup>
import { defineProps, toRefs, ref } from "vue";
import { useQuizStore } from "@/storage/quiz";

const { getSelected } = useQuizStore();

const props = defineProps({
  id: Number,
  index: Number,
  multiple_answers: Boolean,
  question_text: String,
  question_options: Object,
});

const { index } = toRefs(props);
const selected = ref(getSelected(index.value));
</script>

<template>
  <div>
    {{ question_text }}

    <hr />

    <ul v-if="multiple_answers" class="flex flex-col gap-2.5">
      <li v-for="{ id, option_text, correct } in question_options">
        <div v-show="correct">C</div>
        <input
          type="checkbox"
          :name="id"
          :id="id"
          :value="id"
          v-model="selected"
          disabled
        />
        <label :for="id" :class="{ 'bg-green-500': correct && selected.some(s => s === id), 'bg-red-500': correct && !selected.some(s => s === id) }">{{ option_text }}</label>
      </li>
    </ul>
    <ul v-else>
      <li v-for="{ id, option_text, correct } in question_options">
        <span v-show="correct">C</span>
        <input :name="id" type="radio" :value="id" :id="id" v-model="selected" disabled/>
        <label :for="id" :class="{ 'bg-green-500': correct && selected === id, 'bg-red-500': correct && selected !== id }">{{ option_text }}</label>
      </li>
    </ul>
  </div>
</template>
