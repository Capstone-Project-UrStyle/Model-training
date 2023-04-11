#!/bin/bash
CHECKPOINT_DIR="models/model_final/model.ckpt-34865"

python -B src/run_inference.py \
  --checkpoint_path=${CHECKPOINT_DIR} \
  --json_file="data/label/test_no_dup.json" \
  --image_dir="data/images/" \
  --feature_file="data/features/test_features.pkl" \
  --rnn_type="lstm"

# # Extract features of Bi-LSTM without VSE
# CHECKPOINT_DIR="models/model_final/model_bi_no_emb.ckpt"
# python src/run_inference.py \
#   --checkpoint_path=${CHECKPOINT_DIR} \
#   --json_file="data/label/test_no_dup.json" \
#   --image_dir="data/images/" \
#   --feature_file="data/features/test_features_bi_no_emb.pkl" \
#   --rnn_type="lstm"


# # Extract features of VSE model without LSTM
# CHECKPOINT_DIR="models/model_final/model_emb.ckpt"
# python src/run_inference_vse.py \
#   --checkpoint_path=${CHECKPOINT_DIR} \
#   --json_file="data/label/test_no_dup.json" \
#   --image_dir="data/images/" \
#   --feature_file="data/features/test_features_emb.pkl" \

# # Extract features of Siamese Network
# CHECKPOINT_DIR="models/model_final/model_siamese.ckpt"

# python src/run_inference_siamese.py \
#   --checkpoint_path=${CHECKPOINT_DIR} \
#   --json_file="data/label/test_no_dup.json" \
#   --image_dir="data/images/" \
#   --feature_file="data/features/test_features_siamese.pkl"