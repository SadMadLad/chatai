<script setup>
import { computed, ref, toRefs } from "vue";
import { PhX } from "@phosphor-icons/vue";

const props = defineProps({
  areTagsLoading: Boolean,
  errorWhenLoadingTags: Object,
  searchParams: Object,
  tags: Array,
});

const tagClass =
  "bg-primary-300 flex cursor-pointer flex-row items-center gap-0.5 rounded-full px-3 py-1 text-xs";

const { searchParams } = props;
const { areTagsLoading, errorWhenLoading, tags } = toRefs(props);

const emits = defineEmits(["addTag", "handleSearch", "removeTag"]);

const tagToAdd = ref(null);

const tagsArePresent = computed(() => tags.value && tags.value.isPresent());
const searchTagsArePresent = computed(
  () => searchParams.search.tags && searchParams.search.tags.isPresent(),
);

function addTag() {
  emits("addTag", tagToAdd.value);
  tagToAdd.value = null;
}
</script>

<template>
  <aside
    class="relative top-0 w-72 flex-shrink-0 sm:sticky sm:top-12 md:top-20"
  >
    <div class="overflow-y-auto pl-4">
      <div>
        <h4 class="mb-4 text-xl font-bold">Filters</h4>
        <form
          @submit.prevent="$emit('handleSearch')"
          class="flex flex-col gap-2.5 text-sm"
        >
          <div v-if="areTagsLoading">Loading Tag Filters</div>
          <div
            v-else-if="
              !errorWhenLoading && (tagsArePresent || searchTagsArePresent)
            "
            class="flex flex-col gap-1"
          >
            <label class="font-semibold" for="tags">Tags</label>
            <div class="flex flex-wrap gap-1">
              <span
                v-for="tag in searchParams.search.tags"
                :class="tagClass"
                @click="$emit('removeTag', tag)"
                ><span>{{ tag }}</span
                ><PhX size="12"
              /></span>
            </div>
            <div v-if="tagsArePresent" class="relative w-full">
              <select
                v-model="tagToAdd"
                id="tags"
                name="tags"
                @change="addTag"
                class="focus:outline-primary-500 h-8 w-full rounded border border-black bg-white px-2.5"
              >
                <option v-for="tag in tags">{{ tag }}</option>
              </select>
            </div>
            <div v-else>You've selected all the tags</div>
          </div>
          <div class="flex flex-col gap-1">
            <label class="font-semibold" for="title_like">Title</label>
            <input
              v-model="searchParams.search.title_like"
              id="title_like"
              name="title_like"
              class="focus:outline-primary-500 h-8 max-w-full rounded border border-black px-2.5"
            />
          </div>
          <button
            type="submit"
            class="bg-primary-500 rounded px-3.5 py-2 font-semibold text-white"
          >
            Search
          </button>
        </form>
      </div>
    </div>
  </aside>
</template>
