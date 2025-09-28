tolk 1.1

struct Note {
    text: string;
    created: uint32;
}

struct Storage {
    notes: map<address, Note>;
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

// Каждый новый пользователь пишет заметку → map растёт бесконечно
fun addNote(text: string) {
    var st = Storage.load();
    let caller = get_caller();

    st.notes.set(caller, Note{text: text, created: blockchain.now()});
    st.save();
}
