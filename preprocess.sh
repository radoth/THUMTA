bpe_path=/data/home/scv0107/run/zyc/THUMTA/subword-nmt
corpus_path=/data/home/scv0107/run/zyc/125w-zip
thumt_pth=THUMTA/thumt/scripts

sed -i 's// /g' ${corpus_path}/train.en ${corpus_path}/train.zh
python ${bpe_path}/learn_joint_bpe_and_vocab.py --input ${corpus_path}/train.en ${corpus_path}/train.zh -s 32000 -o ${corpus_path}/bpecodes --write-vocabulary ${corpus_path}/vocab.en ${corpus_path}/vocab.zh
python ${bpe_path}/apply_bpe.py -c ${corpus_path}/bpecodes --vocabulary ${corpus_path}/vocab.en --vocabulary-threshold 50 < ${corpus_path}/train.en > ${corpus_path}/train.en.32k
python ${bpe_path}/apply_bpe.py -c ${corpus_path}/bpecodes --vocabulary ${corpus_path}/vocab.zh --vocabulary-threshold 50 < ${corpus_path}/train.zh > ${corpus_path}/train.zh.32k
python ${thumt_pth}/shuffle_corpus.py --corpus ${corpus_path}/train.en.32k ${corpus_path}/train.zh.32k
python ${thumt_pth}/build_vocab.py ${corpus_path}/train.en.32k.shuf ${corpus_path}/vocab.32k.en
python ${thumt_pth}/build_vocab.py ${corpus_path}/train.zh.32k.shuf ${corpus_path}/vocab.32k.zh