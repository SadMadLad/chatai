<script setup>
import { createFavorite, destroyFavorite } from "@/services/apis/favorite";
import { PhHeart, PhSpinnerGap } from "@phosphor-icons/vue";
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/storage/auth";

const { logout } = useAuthStore();
const router = useRouter();

const { favoritableId, favoritableType, favorited } = defineProps({
  favoritableId: Number,
  favoritableType: String,
  favorited: Boolean,
});

const isFavorited = ref(favorited);
const isProcessing = ref(false);
const error = ref(null);

async function favorite() {
  const body = { favoritable_id: favoritableId, favoritable_type: favoritableType };
  try {
    isProcessing.value = true;
    const response = isFavorited.value === true ? await destroyFavorite(body) : await createFavorite(body);

    if (response.status === 401) {
      logout();
      router.push({ name: 'login' });
    } else {
      isFavorited.value = !isFavorited.value;
    }
  } catch(e) {
    error.value = e;
  } finally {
    isProcessing.value = false;
  }
};
</script>

<template>
  <PhSpinnerGap class="animate-spin" v-if="isProcessing" :size="32" />
  <PhHeart v-else class="cursor-pointer drop-shadow" @click="favorite" :weight="isFavorited ? 'fill' : 'duotone'" size="32"/>
</template>
