<script setup>
import { useCollectableDialogStore } from "@/storage/collectable_dialog";
import { PhFolderPlus } from "@phosphor-icons/vue";

const { openDialog, setItemData } = useCollectableDialogStore();

const { collectableId, collectableTitle, collectableType } = defineProps({
  collectableId: Number,
  collectableTitle: String,
  collectableType: String,
});

function setCollectableData() {
  openDialog();
  setItemData(collectableId, collectableTitle, collectableType);
}
</script>

<template>
  <button @click="setCollectableData">
    <PhFolderPlus :size="32" weight="duotone" />
  </button>
</template>
