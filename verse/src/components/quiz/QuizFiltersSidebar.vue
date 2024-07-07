<script setup>
import { computed, ref } from "vue";
import { getTags } from "@/services/apis/tag";

const props = defineProps({ searchParams: Object });
const { searchParams } = props;
defineEmits(["handleSearch"]);

const { error, fetchedData: tags } = getTags();

const tagToAdd = ref(null);

const tagsArePresent = computed(() => tags.value && tags.value.isPresent());
const searchTagsArePresent = computed(
  () => searchParams.search.tags && searchParams.search.tags.isPresent(),
);

function addTag() {
  const currentSearchTags = [...searchParams.search.tags];
  currentSearchTags.unshift(tagToAdd.value);

  const selectedTagsSet = new Set(currentSearchTags);
  const tagsSet = new Set(tags.value);

  tagToAdd.value = null;
  tags.value = [...tagsSet.difference(selectedTagsSet)];
  searchParams.search.tags = [...selectedTagsSet];
}

function removeTag(tag) {
  tags.value.unshift(tag);
  searchParams.search.tags = searchParams.search.tags.filter((t) => t !== tag);
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
          <div
            v-if="!error && (tagsArePresent || searchTagsArePresent)"
            class="flex flex-col gap-1"
          >
            <label class="font-semibold" for="tags">Tags</label>
            <div class="flex flex-wrap gap-1">
              <span
                v-for="tag in searchParams.search.tags"
                class="bg-purple-500"
                @click="removeTag(tag)"
                >{{ tag }}</span
              >
            </div>
            <button type="button" @click="addTag"></button>
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
