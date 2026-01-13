"""add_word_synonyms_table

Revision ID: add_synonyms_table
Revises: change_current_level_to_float
Create Date: 2026-01-11 20:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'add_synonyms_table'
down_revision: Union[str, None] = 'change_level_float'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Check if table already exists
    connection = op.get_bind()
    result = connection.execute(sa.text("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_name='word_synonyms'
    """))
    
    if result.fetchone() is None:
        # Create word_synonyms table
        op.create_table(
            'word_synonyms',
            sa.Column('id', sa.Integer(), nullable=False),
            sa.Column('word_id', sa.Integer(), nullable=False),
            sa.Column('synonym', sa.String(), nullable=False),
            sa.ForeignKeyConstraint(['word_id'], ['words.id'], ondelete='CASCADE'),
            sa.PrimaryKeyConstraint('id')
        )
        op.create_index('idx_word_synonym_word', 'word_synonyms', ['word_id'])
        op.create_index('idx_word_synonym_synonym', 'word_synonyms', ['synonym'])
    else:
        # Table exists, check and create indexes if they don't exist
        index_result = connection.execute(sa.text("""
            SELECT indexname 
            FROM pg_indexes 
            WHERE tablename='word_synonyms' AND indexname='idx_word_synonym_word'
        """))
        if index_result.fetchone() is None:
            op.create_index('idx_word_synonym_word', 'word_synonyms', ['word_id'])
        
        index_result2 = connection.execute(sa.text("""
            SELECT indexname 
            FROM pg_indexes 
            WHERE tablename='word_synonyms' AND indexname='idx_word_synonym_synonym'
        """))
        if index_result2.fetchone() is None:
            op.create_index('idx_word_synonym_synonym', 'word_synonyms', ['synonym'])


def downgrade() -> None:
    op.drop_index('idx_word_synonym_synonym', table_name='word_synonyms')
    op.drop_index('idx_word_synonym_word', table_name='word_synonyms')
    op.drop_table('word_synonyms')
