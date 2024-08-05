<script setup>
import {
  createCollectableMap,
  destroyCollectableMap,
} from "@/services/apis/collectable_map";
import { watch } from "vue";
import { useCollectableDialogStore } from "@/storage/collectable_dialog";

const { computedCollectableItemId, computedCollectableItemType } =
  useCollectableDialogStore();

const collected = defineModel();

const { id: collectionId } = defineProps({
  id: Number,
  title: String,
  description: String,
});

watch(collected, async (isCollected) => {
  const payload = {
    collection_id: collectionId,
    collectable_id: computedCollectableItemId.value,
    collectable_type: computedCollectableItemType.value,
  };

  if (isCollected) await createCollectableMap(payload);
  else await destroyCollectableMap(payload);
});
</script>

<template>
  <div class="flex flex-row justify-between gap-4">
    <span>{{ title }}</span>
    <input type="checkbox" v-model="collected" />
  </div>
</template>
