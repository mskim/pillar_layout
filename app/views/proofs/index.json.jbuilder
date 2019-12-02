json.set! :data do
  json.array! @proofs do |proof|
    json.partial! 'proofs/proof', proof: proof
    json.url  "
              #{link_to 'Show', proof }
              #{link_to 'Edit', edit_proof_path(proof)}
              #{link_to 'Destroy', proof, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end