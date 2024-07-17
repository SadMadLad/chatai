<script setup>
import { createFavorite, destroyFavorite } from "@/services/apis/favorite";
import { PhHeart, PhSpinnerGap } from "@phosphor-icons/vue";
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/storage/auth";

const { logout } = useAuthStore();
const router = useRouter();

const favoritedModel = defineModel();

const { favoritableId, favoritableType } = defineProps({
  favoritableId: Number,
  favoritableType: String,
  favorited: Boolean,
  iconSize: Number,
  styleClass: String,
});

const isProcessing = ref(false);
const error = ref(null);

async function favorite() {
  const body = {
    favoritable_id: favoritableId,
    favoritable_type: favoritableType,
  };
  try {
    isProcessing.value = true;
    const response =
      favoritedModel.value === true
        ? await destroyFavorite(body)
        : await createFavorite(body);

    if (response.status === 401) {
      logout();
      router.push({ name: "login" });
    } else {
      favoritedModel.value = !favoritedModel.value;
    }
  } catch (e) {
    error.value = e;
  } finally {
    isProcessing.value = false;
  }
}
</script>

<template>
  <PhSpinnerGap
    class="animate-spin"
    v-if="isProcessing"
    :size="iconSize || 32"
  />
  <PhHeart
    v-else
    class="cursor-pointer drop-shadow"
    :class="styleClass"
    @click.stop="favorite"
    :weight="favoritedModel ? 'fill' : 'duotone'"
    :size="iconSize || 32"
  />
</template>
